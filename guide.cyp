// Use this guide to test the graph

// Visualise the Schema:
CALL db.schema.visualization

// 1. Find the top 3 least busy airports (least arrivals AND departures)
MATCH (c)-[:ARRIVES]-(a:Airport)-[:DEPARTS]-(f)
RETURN a, COLLECT(a) as leastBusyAirports
ORDER BY SIZE(leastBusyAirports) ASC LIMIT 3

// 2. Find closest City to given Airport
MATCH (a:Airport {iata: 'DEN'}), (c:City)
WHERE (a)-[:NEARBY]->(c)
RETURN a, c

// 3. Find Airport with most departing Flights
MATCH (flights)-[:DEPARTS]->(airport)
RETURN  airport, COLLECT(flights) as departureAirports
ORDER BY SIZE(departureAirports) DESC LIMIT 1

// 4. Find the Station with the most rainfall recorded
MATCH (w:Weather)
WITH max(w.rainfall) as maxRainfall
MATCH (s:Station)-[:OBSERVES]->(n:Weather {rainfall: maxRainfall})
RETURN s

// 5. Find the CO2 Emissions of a given flight IATA
MATCH (f:Flight {iata: 'BA5360'})-[:EMITS]-(e)
RETURN e, f

// 6. Find the flight with the highest CO2 Emissions
MATCH (f:Flight)-[:EMITS]->(e:Emission)
RETURN f.iata, max(e.totalCO2) as maxEmissions
ORDER BY maxEmissions DESC LIMIT 1

// 7. Find the latest Flight that departs ATL and arrives at LAX
MATCH (f:Flight {departure: 'ATL', arrival: 'LAX'})
WITH max(f.takeoff) as latestFlight
MATCH (f:Flight {departure: 'ATL', arrival: 'LAX', takeoff: latestFlight})
RETURN f

// 8. Find the average Wind Speed for Flight with iata = AA1732
MATCH (f:Flight {iata: 'AA1732'})-[:DEPARTS]-(a)-[:NEARBY]-(c)-[:HAS_WEATHER]-(w:Weather)
RETURN w.avgWindSpeed, w, f, a, c

// 9. Find the most common Airport for arriving to the Bronx, NY
MATCH (c:City {name: 'Bronx'})-[:NEARBY]-(a:Airport)-[:ARRIVES]-(f)
RETURN a, collect(f) as arrivalAirports
ORDER BY SIZE(arrivalAirports) DESC LIMIT 1

// 10. Find the top 5 airlines with the most CO2 Emissions
MATCH (a:Airline)-[:CARRIES]->(f)-[:EMITS]->(e:Emission)
RETURN a.name, sum(e.totalCO2) as totalEmissions
ORDER BY totalEmissions DESC LIMIT 5
