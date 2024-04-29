import Cocoa
import CreateML
import CoreML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/badalaryal/Downloads/twitter-sanders-apple3.csv"))

let(trainingData, testingData) = data.randomSplit(by:0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMatrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMatrics.classificationError)

let metaData = MLModelMetadata(author: "Badal Aryal",shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/badalaryal/Downloads/X-SentimentClassifier.mlmodel"))

try sentimentClassifier.prediction(from: "@Apple is a terrible company!")

try sentimentClassifier.prediction(from: "@Apple is a best company!")

try sentimentClassifier.prediction(from: "@Apple ads are ok!")


