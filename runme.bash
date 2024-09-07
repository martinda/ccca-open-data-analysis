#!/bin/bash

echo "Theft of Motor Vehicle"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Auto_Theft_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.501%2C45.466%2C-75.427%2C45.487&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp > auto_theft.json
groovy a.groovy auto_theft.json

echo "Criminal Offenses"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Criminal_Offences_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.496%2C45.467%2C-75.422%2C45.488&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp >crimes.json
groovy a.groovy crimes.json

# Hate crimes
echo "Hate crimes"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Hate_Crime_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=true&outSR=4326&f=json" | json_pp > hate_crimes.json
groovy a.groovy hate_crimes.json

echo "Homicides"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Homicide_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.502%2C45.466%2C-75.428%2C45.487&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp >homicides.json
groovy a.groovy homicides.json

echo "Bike theft"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Bike_Theft_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.500%2C45.466%2C-75.426%2C45.487&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp >bike_theft.json
groovy a.groovy bike_theft.json

echo "Shootings"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Shootings_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.498%2C45.466%2C-75.424%2C45.487&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp >shootings.json
groovy a.groovy shootings.json

# Does not work because no location data
echo "Overdoses"
curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Overdose_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json" | json_pp >overdoses.json
groovy a.groovy overdoses.json
