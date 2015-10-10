module.exports = function(doc) {

    /**
     * Add data filter, only store the related fields into elatissearch.
     */
    
    if (doc.ns == "opentown.users") {
        doc["data"] = _.pick(doc.data, ["_id", "nickname", "deleted", "phone", "intro"]);
    } else
    if (doc.ns == "opentown.topics") {
        doc["data"] = _.pick(doc.data, ["_id", "title", "abstract", "deleted", "statements"]);
        if (doc.data && doc.data.statements) {
            doc.data.statements = _.pick(doc.data.statements, ["content"]);
        }
    }

    console.log("transformer: " + JSON.stringify(doc))
    return doc
}
