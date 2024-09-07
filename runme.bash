#!/bin/bash

curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Auto_Theft_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.501%2C45.466%2C-75.427%2C45.487&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp > auto_theft.json

echo "Auto theft"
groovy a.groovy auto_theft.json

curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Criminal_Offences_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&geometry=-75.496%2C45.467%2C-75.422%2C45.488&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json" | json_pp >crimes.json

echo "Crimes"
groovy a.groovy crimes.json

# Hate crimes
#curl -s -X GET "https://services7.arcgis.com/2vhcNzw0NfUwAD3d/arcgis/rest/services/Hate_Crime_Open_Data/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=true&outSR=4326&f=json" | json_pp > hate_crimes.json

#echo "Hate crimes"
# Analysis does not work because no geo coordinates are returned in the json response
#groovy a.groovy hate_crimes.json
