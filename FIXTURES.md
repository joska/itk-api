
# Create using irb
Institution.create(name:'oxford', dateCreated:'2016-01-02 01:00:00', dateModified:'2016-01-02 01:00:00')
Manufacturer.create(name:'oxford', dateCreated:'2016-01-02 01:00:00', dateModified:'2016-01-02 01:00:00')
Person.create(name:'John Doe', dateCreated:'2016-01-02 01:00:00', dateModified:'2016-01-02 01:00:00')
Item.create(serialNumber:'alphanumeric', type:'item',manufacturerName:'mycollitem001', dateCreated:'2016-01-02 01:00:00', dateModified:'2016-01-02 01:00:00',institution:Institution._id2ref('58a55d9d8e5f2b073aa4a15e'), manufacturer: Manufacturer._id2ref('58a55ea18e5f2b07dc6981bd'), person: Person._id2ref('58a55ea68e5f2b07dc6981be'))


# Example JSON files from MongoDB
## Person
{
    "_id" : ObjectId("58a55ea68e5f2b07dc6981be"),
    "name" : "John Doe",
    "dateCreated" : ISODate("2016-01-02T01:00:00.000Z"),
    "dateModified" : ISODate("2016-01-02T01:00:00.000Z")
}

## Institution
{
    "_id" : ObjectId("58a55d9d8e5f2b073aa4a15e"),
    "name" : "oxford",
    "dateCreated" : ISODate("2016-01-02T01:00:00.000Z"),
    "dateModified" : ISODate("2016-01-02T01:00:00.000Z")
}

## Manufacturer
{
    "_id" : ObjectId("58a55ea68e5f2b07dc6981be"),
    "name" : "John Doe",
    "dateCreated" : ISODate("2016-01-02T01:00:00.000Z"),
    "dateModified" : ISODate("2016-01-02T01:00:00.000Z")
}