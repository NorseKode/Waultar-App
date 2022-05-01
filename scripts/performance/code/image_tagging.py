import json
import os
from .diagram_creator import *

def taggedImageReadingToConsole(path, savePath):
    taggedImages = json.load(open(path))

    totalTime = taggedImages["elapsedTime"]
    setupClassifierTime = 0
    imagesTagged = []
    summedImagesTaggedTime = 0
    loadingOfImagesCount = 0
    loadingOfImagesTime = 0
    updateRepoCount = 0
    updateRepoTime = 0
    taggedCount = (taggedImages["metadata"])["tagged count"]
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
        if point["key"] == "Update Repo":
            updateRepoCount = updateRepoCount + 1
            updateRepoTime = updateRepoTime + point["elapsedTime"]
    
    setupPercentage = setupClassifierTime / classifyingTime * 100
    loadImagePercentage = loadingOfImagesTime / classifyingTime * 100
    classifyImagePercentage = summedImagesTaggedTime / classifyingTime * 100
    updateRepoPercentage = updateRepoTime / classifyingTime * 100
    other = 100 - setupPercentage - loadImagePercentage - classifyImagePercentage - updateRepoPercentage
    percentData = [setupPercentage, loadImagePercentage, classifyImagePercentage, other]
    percentLabel = ["Setup", "Load Image", "Classify Image", "Update Repo", "Other"]
    createPieChart(percentData, percentLabel, "Percentage of time used in classifier", savePath)

    print(f"Image tagging took {totalTime / 1000000} seconds")
    print(f"With image classifying taking {classifyingTime / totalTime}% of the time")
    print(f"\tWith {taggedCount} images tagged in {summedImagesTaggedTime / 1000000} second");
    print(f"\t\tSetup of classifier took {setupPercentage}% of the classifying time")
    print(f"\t\tLoading of images from the database took {loadImagePercentage}% of the classifying time")
    print(f"\t\tUpdate of repo from the database took {updateRepoPercentage}% of the classifying time")
    print(f"\t\tClassifying of images took {classifyingTime}% of the classifying time used")
    print(f"\t\tThat's an average tagging time of {(summedImagesTaggedTime / taggedCount) / 1000000} seconds per image")