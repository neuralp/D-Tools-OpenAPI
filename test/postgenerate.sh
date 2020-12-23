#!/bin/sh

# if your using NPM to run this is is running one directory up from the API, so change
# the relative path
pwd | grep dtapi | wc -l > /dev/null
if [ $? -eq 0 ]; then
    cd dtapi
fi

if [ -e "./runtime.ts" ]; then
    # the 'FormData' is not available in NodeJS and TypeScript, so we must remove it
    sed -i -r 's/export type HTTPBody = Json \| FormData/export type HTTPBody = Json/g' ./runtime.ts
    sed -i -r 's/context\.body instanceof FormData \|\| //g' ./runtime.ts
fi

if [ -e "./apis/ProductApi.ts" ]; then
    # So the D-Tools API doesn't quite meet the OpenAPI specifications and contains a
    # single path with two very different results based on the parameters sent.  Since
    # the specification won't let me define duplicate endpoints, I just have to modify
    # the endpoint code afterwards and add the plural (s) onto the path
    sed -i -r 's/path: `\/Subscribe\/ProductCatalog`,/path: `\/Subscribe\/ProductCatalogs`,/g' ./apis/ProductApi.ts
fi

if [ -e "./apis/ProjectApi.ts" ]; then
    # So the D-Tools API doesn't quite meet the OpenAPI specifications and contains a
    # single path with two very different results based on the parameters sent.  Since
    # the specification won't let me define duplicate endpoints, I just have to modify
    # the endpoint code afterwards and add the plural (s) onto the path
    sed -i -r 's/path: `\/Subscribe\/Project`,/path: `\/Subscribe\/Projects`,/g' ./apis/ProjectApi.ts
fi