#!/bin/bash
sysctl -w vm.max_map_count=262144  # see https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
