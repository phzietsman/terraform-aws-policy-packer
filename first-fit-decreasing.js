function firstFitDecreasing(collection, binSize) {

    var collectionObj = [];

    for (var id in collection) {
        collectionObj.push({
            id : id,
            statement : collection[id],
            size : collection[id].length + 2    // Each SIDs require a ",\n" between them
        });
    }

    var collectionCount = collectionObj.length;
    var collectionSorted = collectionObj.sort(function(a, b) { return b.size - a.size; });

    var binCount = 0;
    var binMemory = [];

    for (var i = 0; i < collectionCount; i++) {

        var j = 0;

        for(j = 0; j < binCount; j++) {
            
            if (binMemory[j].capacity >= collectionSorted[i].size) {
                binMemory[j].capacity = binMemory[j].capacity - collectionSorted[i].size;
                binMemory[j].collection.push(collectionSorted[i]);
                break;
            }
        }

        if(j == binCount) {
            binMemory[binCount] = {
                capacity : binSize,
                collection: []
            };

            binMemory[binCount].capacity = binMemory[binCount].capacity - collectionSorted[i].size;
            binMemory[binCount].collection.push(collectionSorted[i]);
            binCount++;
        }

    }

    return binMemory;
}

firstFitDecreasing(INPUT_COLLECTION, INPUT_BIN_SIZE);



