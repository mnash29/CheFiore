"""Convert a caffe model to a coreml model

Must use coremltools==3.0 and run in a python2.7 environment
"""
from os.path import join, dirname, abspath

import coremltools

datapath = join(dirname(dirname(abspath(__file__))), "data", "flower_classifier")

caffe_model = (
    join(datapath, "oxford102.caffemodel"),
    join(datapath, "deploy.prototxt"),
)

labels = join(datapath, "flower-labels.txt")

coreml_model = coremltools.converters.caffe.convert(caffe_model,
                                                    class_labels=labels,
                                                    image_input_names="data")

coreml_model.save(join(datapath, "FlowerClassifier.mlmodel"))
