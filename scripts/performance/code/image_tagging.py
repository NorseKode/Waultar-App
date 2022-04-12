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
    classifyingTime = info["elapsedTime"]

    for point in info["childs"]:
        if point["key"] == "Classify Image":
            summedImagesTaggedTime = summedImagesTaggedTime + point["elapsedTime"]
            imagesTagged.append(point)
        if point["key"] == "Setup of classifier":
            setupClassifierTime = point["elapsedTime"]
        if point["key"] == "Loading of images":
            loadingOfImagesCount = loadingOfImagesCount + 1
            loadingOfImagesTime = loadingOfImagesTime + point["elapsedTime"]

    print(f"Image tagging took {totalTime / 1000000} seconds")
    print(f"With image classifying taking {classifyingTime / totalTime}% of the time")
    print(f"\tWith {len(imagesTagged)} images tagged in {summedImagesTaggedTime / 1000000} second");
    print(f"\t\tSetup of classifier took {setupClassifierTime / classifyingTime * 100}% of the classifying time")
    print(f"\t\tLoading of images from the database took {loadingOfImagesTime / classifyingTime * 100}% of the classifying time")
    print(f"\t\tClassifying of images took {summedImagesTaggedTime / classifyingTime * 100}% of the classifying time used")
    print(f"\t\tThat's an average tagging time of {(summedImagesTaggedTime / len(imagesTagged)) / 1000000} seconds per image")