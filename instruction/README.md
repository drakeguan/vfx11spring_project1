# Requirements

* Matlab
* a terminal (Linux has it!)
* uncompressed file structure of this project

# Instructions

* `cd ~/program` (the source code folder)
* for each testing with different parameters, run `matlab -nodesktop -nosplash -r` followed by a function call to 'main'.
* *mlr* stands for `matlab -nodesktop -nosplash -r`.
* ex, `mlr "main('../image/original/scene')"`
* after that, 3 files are generated:
  * scene.hdr (HDR in radiance format)
  * scene_tone_mapped.hdr (LDR in randiance format)
  * scene_tone_mapped.png (LDR in PNG format)

# Configurations

* servers, main('../image/original/servers', 0.3)
* scene, main('../image/original/scene', 0.3, 100)
* station, main('../image/original/station', 0.4, 2000)
* restroom, main('../image/original/restroom', 0.5, 1000)
* digimax_gate:, main('../image/original/digimax_gate', 0.23, 100)
* desktop02, main('../image/original/desktop02', 0.5, 100)
* desktop01, main('../image/original/desktop01', 0.2, 50)
* corridor, main('../image/original/corridor', 0.5, 1000)

# Function signature

For function 'main', the parameters are as following in ordering:

* folder: image set path.
* alpha_: high key or low key?
* white_: whiteness
* lambda: smothness ration.
* prefix: output prefix
* (srow, scol): reduced image size.
