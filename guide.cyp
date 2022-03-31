// Use this guide to test the graph

// 1. Visualise the schema:
CALL db.schema.visualization()

// 2. Find closest City to given Airport
MATCH (a:Airport {iata: 'DEN'}), (c:City)
WHERE (a)-[:NEARBY]->(c)
RETURN a, c

// 3. Find Airport with most departing Flights
MATCH (flights)-[:DEPARTS]->(airport)
RETURN  airport, COLLECT(flights) as departureAirports
ORDER BY SIZE(departureAirports) DESC LIMIT 1

// 4. Find the City with the most rainfall on 01/01/2022

// 5. Find the Airline with the most Flights on 01/01/2022

// 6. Find the maxTemp and minTemp of Chicago on 01/01/2022

// 7. Find the 
