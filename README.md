# blink_detector
Counts blinks and detects whether a person on video is sleeping.
This project is based on https://www.pyimagesearch.com/2017/04/24/eye-blink-detection-opencv-python-dlib/ with several modifications:
* If person on video close eyes for more than 2 seconds, caption \"SLEEPING ALERT\" is displayed
* A different solution for blink detection is implemented
* Solution is deployed using docker-compose

## Usage
1. Make sure you have the updated version of docker-compose.
Installation guide for the latest version is here: https://docs.docker.com/compose/install/
2. If you want to use a video stream from web camera, run `xhost +local:root`
3. Running:
  * Web camera: `docker-compose up --build` (if you are running it not for the first time, you may drop the `--build` flag)
  * Video file:
    1. Place you video to the project folder
    2. `VIDEO="yourfilename.mp4" docker-compose up --build`

The process of building container for the first time may take considerable time (took me 15 minutes), but after that rebuilding it for another video will take much less, since all previous steps are cached.

To end stream from web camera, press `q`.

The output video `out.mp4` (with captions) will be saved to the project folder.

## How it works
After application is successfully launched, you should be able to see your web camera stream / video from the file.
The first 2 seconds are dedicated for setup, so please
* let your eyes be relaxed
* try not to blink

This will let application to learn your eyes aspect ratio in relaxed state and better detect if they are closed.
In fact, what happening is application calculates your eyes' aspect ratio at each frame and append it to a vector.
After data is collected, the mean and variance for this random sample are calculated, and the treshold for a blink is set to
`mean - sqrt(variance)`. This worked better that a static threshold, since different people have different eye aspect ration in a relaxed state, and
threshold should be adapted.

## Some issues
* If person on video squints, eye aspect ration may start to oscilate near the learned threshold, detecting numerous "false positive"
blinks.

**Possible solution:** dynamically learn the distribution of EAR, add option to recalibrate it during video stream, or use advanced anomaly detection algorithm
* Face landmark detection performs not really well with bad lightning

**Possible solution:** train better face landmark detector, using data with different lightning levels.
* Solution is deployed only for Linux"
* Adding new video file requires container rebuilding
* Vido quality can be improved
