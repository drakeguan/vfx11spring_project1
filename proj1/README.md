# Digital Visual Effects, Spring 2011
## project #1: High Dynamic Range Imaging ([original link](http://www.csie.ntu.edu.tw/~cyy/courses/vfx/11spring/assignments/proj1/))

D99944013,
Shuen-Huei (Drake) Guan,
(drake.guan@gmail.com)

doc online: [https://github.com/drakeguan/vfx11spring/tree/master/proj1](https://github.com/drakeguan/vfx11spring/tree/master/proj1 "online document")

### Project description

High dynamic range (HDR) images have much larger dynamic ranges than traditional images' 256 levels. In addition, they correspond linearly to physical irradiance values of the scene. Hence, they are useful for many graphics and vision applications. In this assignment, you are asked to finish the following tasks to assemble an HDR image in a group of two.

[![HDR artifact](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/servers_tone_mapped_thumb.png "HDR artifcat")](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/servers_tone_mapped.png)

### Algorithm

The following algorithms are implemented:

* HDR: Debevec's algorithm in Matlab. (gsolve.m + hdrDebevec.m)
* Tone Mapping: Reinhard's algorithm in Matlab. (tmoReinhard02.m)

### Approach

#### Taking photos

Canon 5D EOS is used to take as many pictures as possible for each scene. In order to make sure the *stillness*, a tripod is used. Furthermore, [DSLR Camera Remote](http://www.ononesoftware.com/products/dslr-camera-remote/ "DSLR Camera Remote") is also installed on a Mac wired with a USB line to the camera to do somehow *remote shooting without touching the camera*. The results turn out good enough such that no alignment algorithm is needed.

#### Alignment

Skip.

#### Camera response curve & HDR

Debevec's algorithm (gsolve.m + hdrDebevec.m) is used to recover the camera's response curve. 

![camera response curve](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/camera_response_curve.png "reconstructed camera response curve for the used Canon 5D")

* *gsolve.m* is borrowed from Debevec's paper for reconstructing the camera's response curve,
* *hdrDebevec.m* is to convert those LDR images into a HDR image.

In this algorithm, several sampling pixels need to pick up to feed into *gsolve*. According to the paper and slides, 50~100 pixels are reasonable number. The issue comes next is, *which pixel should I pick up into the sampling bin?* A random pick-up has been tested several times and if the number is bigger enough, the result looks good. But that is not that guaranteed. By observation, an image shrinking operator can be applied to the original images to get smaller ones. Those reduced images stil capture somehow the original images' characteristics. As long as the size is smaller enough, we can feed all pixels in smaller ones to *gsolve*. The default size of the reduced images is (width: 20, height: 10), which turns out 200 sampling pixels, bigger enough for *gsolve*.

One more issue to take care of in *hdrDebevec* is computational error. Because Matlab is such powerful that there is seldom error while computing out *NaN* or *Inf*. After several testing, we found we should replace those *NaN* and *Inf* by 0 to make the following tone mapping work.

#### Tone mapping

Reinhard's algorithm is implemented in *tmoReinhard02.m*. Only global operator is implemented here. 

> The only trick here is that we first convert those images into luminance (or intensity). That is, converting 3-channel images into 1-channel images. Then, apply tone mapping operator on those luminance images. And finally multiply tone-mapped luminance by resting colors to get the final result. The reason behind this is a really interesting discovery. If the tone mapping operator is applied separately on each channel, the resulting LDR would have some sort of color shifting cause each channel has different *LwMean*!

The above idea is still questionable and doubtable cause I haven't spent much time to realise the physical meanings behind. That is just my random thought and I even rollback the code to apply directly on all 3 channels instead of the luminance!

### Results

[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/desktop01_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/desktop01_tone_mapped.png)
[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/desktop02_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/desktop02_tone_mapped.png)
[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/restroom_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/restroom_tone_mapped.png)
[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/scene_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/scene_tone_mapped.png)
[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/station_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/station_tone_mapped.png)
[![results](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped-thumb/servers_tone_mapped_thumb.png)](https://github.com/drakeguan/vfx11spring/raw/master/proj1/image/tone-mapped/servers_tone_mapped.png)

Please look at the *image/tone-mapped* folder.

### References

* Paul E. Debevec, Jitendra Malik, Recovering High Dynamic Range Radiance Maps from Photographs, SIGGRAPH 1997
* Matlab, http://www.mathworks.com/help/techdoc/

