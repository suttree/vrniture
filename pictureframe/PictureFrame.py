#!/usr/bin/python

from __future__ import absolute_import, division, print_function, unicode_literals
''' Simplified slideshow system ufrom pi3d
https://github.com/pi3d/pi3d_demos
'''
import os
import time
import random
import sys
sys.path.insert(1, '/home/pi/pi3d')

import pi3d
from PIL import Image, ExifTags, ImageFilter # these are needed for getting exif data from images

#####################################################
# these variables are constants
#####################################################
PIC_DIR = '/home/pi/src/vrniture-pictures/' #'textures'
FPS = 20
FIT = True
EDGE_ALPHA = 0 # see background colour at edge. 1.0 would show reflection of image
BACKGROUND = (0, 0, 0, 1.0)
RESHUFFLE_NUM = 1 # times through before reshuffling
RECENT_N = 0 # shuffle the most recent ones to play before the rest
CHECK_DIR_TM = 86400 # seconds to wait between checking if directory has changed
BLUR_EDGES = False # use blurred version of image to fill edges - will override FIT = False
BLUR_AMOUNT = 12 # larger values than 12 will increase processing load quite a bit
BLUR_ZOOM = 1.0 # must be >= 1.0 which expands the backgorund to just fill the space around the image

# Random ken burns or not - DG 25/4/20
KENBURNS = bool(random.getrandbits(1)) # will set FIT->False and BLUR_EDGES->False

KEYBOARD = False # set to False when running headless to avoid curses error. True for debugging

#####################################################
# these variables can be altered using MQTT messaging
#####################################################
time_delay = 120 # between slides
fade_time = 5.0
shuffle = True # shuffle on reloading
date_from = None
date_to = None
quit = False
paused = False # NB must be set to True after the first iteration of the show!

#####################################################
# only alter below here if you're keen to experiment!
#####################################################
if KENBURNS:
  FIT = False
  BLUR_EDGES = False

if BLUR_ZOOM < 1.0:
  BLUR_ZOOM = 1.0

delta_alpha = 1.0 / (FPS * fade_time) # delta alpha
last_file_change = 0.0 # holds last change time in directory structure
next_check_tm = time.time() + CHECK_DIR_TM # check if new file or directory every hour

#####################################################
# some functions to tidy subsequent code
#####################################################
def tex_load(fname, orientation, size=None):
  try:
    im = Image.open(fname)
    im.putalpha(255) # this will convert to RGBA and set alpha to opaque
    if orientation == 2:
        im = im.transpose(Image.FLIP_LEFT_RIGHT)
    if orientation == 3:
        im = im.transpose(Image.ROTATE_180) # rotations are clockwise
    if orientation == 4:
        im = im.transpose(Image.FLIP_TOP_BOTTOM)
    if orientation == 5:
        im = im.transpose(Image.FLIP_LEFT_RIGHT).transpose(Image.ROTATE_270)
    if orientation == 6:
        im = im.transpose(Image.ROTATE_270)
    if orientation == 7:
        im = im.transpose(Image.FLIP_LEFT_RIGHT).transpose(Image.ROTATE_90)
    if orientation == 8:
        im = im.transpose(Image.ROTATE_90)
    if BLUR_EDGES and size is not None:
      wh_rat = (size[0] * im.size[1]) / (size[1] * im.size[0])
      if abs(wh_rat - 1.0) > 0.01: # make a blurred background
        (sc_b, sc_f) = (size[1] / im.size[1], size[0] / im.size[0])
        if wh_rat > 1.0:
          (sc_b, sc_f) = (sc_f, sc_b) # swap round
        (w, h) =  (round(size[0] / sc_b / BLUR_ZOOM), round(size[1] / sc_b / BLUR_ZOOM))
        (x, y) = (round(0.5 * (im.size[0] - w)), round(0.5 * (im.size[1] - h)))
        box = (x, y, x + w, y + h)
        blr_sz = (int(x * 512 / size[0]) for x in size)
        im_b = im.resize(size, resample=0, box=box).resize(blr_sz)
        im_b = im_b.filter(ImageFilter.GaussianBlur(BLUR_AMOUNT))
        im_b = im_b.resize(size, resample=Image.BICUBIC)
        im_b.putalpha(round(255 * EDGE_ALPHA))  # to apply the same EDGE_ALPHA as the no blur method.
        im = im.resize((int(x * sc_f) for x in im.size), resample=Image.BICUBIC)
        im_b.paste(im, box=(round(0.5 * (im_b.size[0] - im.size[0])),
                            round(0.5 * (im_b.size[1] - im.size[1]))))
        im = im_b # have to do this as paste applies in place
    tex = pi3d.Texture(im, blend=True, m_repeat=True, automatic_resize=True, free_after_load=True)
  except Exception as e:
    print('''Couldn't load file {} giving error: {}'''.format(fname, e))
    tex = None
  return tex

def check_changes():
  global last_file_change
  update = False
  for root, _, _ in os.walk(PIC_DIR):
      mod_tm = os.stat(root).st_mtime
      if mod_tm > last_file_change:
        last_file_change = mod_tm
        update = True
  return update

def get_files(dt_from=None, dt_to=None):
  # dt_from and dt_to are either None or tuples (2016,12,25)
  if dt_from is not None:
    dt_from = time.mktime(dt_from + (0, 0, 0, 0, 0, 0))
  if dt_to is not None:
    dt_to = time.mktime(dt_to + (0, 0, 0, 0, 0, 0))
  global shuffle, PIC_DIR, EXIF_DATID, last_file_change
  file_list = []
  extensions = ['.png','.JPG', '.jpg','.jpeg'] # can add to these
  for root, _dirnames, filenames in os.walk(PIC_DIR):
      mod_tm = os.stat(root).st_mtime # time of alteration in a directory
      if mod_tm > last_file_change:
        last_file_change = mod_tm
      for filename in filenames:
          ext = os.path.splitext(filename)[1].lower()
          if ext in extensions and not '.AppleDouble' in root and not filename.startswith('.'):
              file_path_name = os.path.join(root, filename)
              include_flag = True
              orientation = 1 # this is default - unrotated
              if EXIF_DATID is not None and EXIF_ORIENTATION is not None:
                try:
                  im = Image.open(file_path_name) # lazy operation so shouldn't load (better test though)
                  print(filename, end="")
                  exif_data = im._getexif()
                  print('orientation is {}'.format(exif_data[EXIF_ORIENTATION]))
                  dt = time.mktime(
                        time.strptime(exif_data[EXIF_DATID], '%Y:%m:%d %H:%M:%S'))
                  orientation = int(exif_data[EXIF_ORIENTATION])
                except Exception as e: # NB should really check error here but it's almost certainly due to lack of exif data
                  print('trying to read exif', e)
                  dt = os.path.getmtime(file_path_name) # so use file last modified date
                if (dt_from is not None and dt < dt_from) or (dt_to is not None and dt > dt_to):
                  include_flag = False
              if include_flag:
                file_list.append((file_path_name, orientation, os.path.getmtime(file_path_name))) # iFiles now list of tuples (file_name, orientation) 
  if shuffle:
    file_list.sort(key=lambda x: x[2]) # will be later files last
    temp_list_first = file_list[-RECENT_N:]
    temp_list_last = file_list[:-RECENT_N]
    random.shuffle(temp_list_first)
    random.shuffle(temp_list_last)
    file_list = temp_list_first + temp_list_last
  else:
    file_list.sort() # if not suffled; sort by name
  return file_list, len(file_list) # tuple of file list, number of pictures

EXIF_DATID = None # this needs to be set before get_files() above can extract exif date info
EXIF_ORIENTATION = None
for k in ExifTags.TAGS:
  if ExifTags.TAGS[k] == 'DateTimeOriginal':
    EXIF_DATID = k
  if ExifTags.TAGS[k] == 'Orientation':
    EXIF_ORIENTATION = k


DISPLAY = pi3d.Display.create(x=0, y=0, frames_per_second=FPS,
              display_config=pi3d.DISPLAY_CONFIG_HIDE_CURSOR, background=BACKGROUND)
CAMERA = pi3d.Camera(is_3d=False)
print(DISPLAY.opengl.gl_id)

shader = pi3d.Shader("/home/pi/src/vrniture/pictureframe/shaders/blend_new")
slide = pi3d.Sprite(camera=CAMERA, w=DISPLAY.width, h=DISPLAY.height, z=5.0)
slide.set_shader(shader)
slide.unif[47] = EDGE_ALPHA


# images in iFiles list
nexttm = 0.0
iFiles, nFi = get_files(date_from, date_to)
random.shuffle(iFiles)

# now just limit the files - DG
iFiles = iFiles[:50]
nFi = len(iFiles)

next_pic_num = 0
sfg = None # slide for background
sbg = None # slide for foreground
if nFi == 0:
  print('No files selected!')
  exit()


num_run_through = 0
while DISPLAY.loop_running():
  tm = time.time()
  if nFi > 0:
    if (tm > nexttm and not paused) or (tm - nexttm) >= 86400.0: # this must run first iteration of loop
      nexttm = tm + time_delay
      a = 0.0 # alpha - proportion front image to back
      sbg = sfg
      sfg = None
      while sfg is None: # keep going through until a usable picture is found TODO break out how?
        pic_num = next_pic_num
        sfg = tex_load(iFiles[pic_num][0], iFiles[pic_num][1], (DISPLAY.width, DISPLAY.height))
        next_pic_num += 1
        if next_pic_num >= nFi:
          DISPLAY.destroy() # don't loop, exit one we've rendered all the pictures - DG

      if sbg is None: # first time through
        sbg = sfg
      slide.set_textures([sfg, sbg])
      slide.unif[45:47] = slide.unif[42:44] # transfer front width and height factors to back
      slide.unif[51:53] = slide.unif[48:50] # transfer front width and height offsets

      wh_rat = (DISPLAY.width * sfg.iy) / (DISPLAY.height * sfg.ix)
      if (wh_rat > 1.0 and FIT) or (wh_rat <= 1.0 and not FIT):
        sz1, sz2, os1, os2 = 42, 43, 48, 49
      else:
        sz1, sz2, os1, os2 = 43, 42, 49, 48
        wh_rat = 1.0 / wh_rat

      slide.unif[sz1] = wh_rat
      slide.unif[sz2] = 1.0
      slide.unif[os1] = (wh_rat - 1.0) * 0.5
      slide.unif[os2] = 0.0

      if KENBURNS:
          xstep, ystep = (slide.unif[i] * 2.0 / time_delay for i in (48, 49))
          slide.unif[48] = 0.0
          slide.unif[49] = 0.0

    if KENBURNS:
      t_factor = nexttm - tm
      slide.unif[48] = xstep * t_factor
      slide.unif[49] = ystep * t_factor

    if a < 1.0: # transition is happening
      a += delta_alpha
      slide.unif[44] = a
    else: # no transition effect safe to resuffle etc
      if tm > next_check_tm:
        if check_changes():
          iFiles, nFi = get_files(date_from, date_to)
          num_run_through = 0
          next_pic_num = 0
        next_check_tm = tm + CHECK_DIR_TM # once per hour

    slide.draw()

try:
  client.loop_stop()
except Exception as e:
  print("this was going to fail if previous try failed!")
DISPLAY.destroy()

# Run the main vrnjr script if we're done
import os
os.system("/usr/bin/env python /home/pi/src/vrniture/vrn-run.py >> /tmp/cron.log 2>&1")
