#!/bin/bash

# Import our enriched airline data as the 'airlines' collection
mongoimport --host mongo -d agile_data_science -c origin_dest_distances --file /home/origin_dest_distances.jsonl
mongo --host mongo agile_data_science --eval 'db.origin_dest_distances.ensureIndex({Origin: 1, Dest: 1})'
