import {readdirSync,writeFileSync}   from 'fs'

let jsonOut = {photos:[]}

const files= readdirSync('.')

let group=1
let numGroup=1
for (let i=1; i<files.length; i++){
    if (files[i]!="description.json" && files[i]!="gen.js"){
        if (numGroup==2){
            numGroup=1
            group++
        }else{
            numGroup++
        }
        jsonOut.photos.push(
            {
                "filename"         : files[i],
                "description"      : "",
                "hiddenDescription": "",
                "group"            : group
            }
        )
    }
}

let prettyText = JSON.stringify(jsonOut, null, "  ")

writeFileSync('description.json',prettyText)

