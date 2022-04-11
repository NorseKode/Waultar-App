import json
import os

def taggedImageReadingToConsole(path):
    taggedImages = json.load(open(path))

    totalTime = taggedImages["elapsedTime"]
    setupClassifierTime = 0
    imagesTagged = []
    summedImagesTaggedTime = 0
    loadingOfImagesCount = 0
    loadingOfImagesTime = 0
    info = taggedImages["childs"][0]

    for point in info["childs"]:
        if point["key"] == "Classify Image":
            summedImagesTaggedTime = summedImagesTaggedTime + point["elapsedTime"]
            imagesTagged.append(point)
        if point["key"] == "Setup of classifier":
            setupClassifierTime = point["elapsedTime"]
            # TODO loading of images

    print(f"Image tagging took {totalTime / 100000} seconds")
    print(f"\tWith {len(imagesTagged)} images tagged in {summedImagesTaggedTime / 100000} second, representing {summedImagesTaggedTime / totalTime}% of the time used")
    print(f"\tAnd an average tagging time of {(summedImagesTaggedTime / len(imagesTagged)) / 100000} seconds per image")
    print(f"Setup of classifier took {setupClassifierTime} microseconds")