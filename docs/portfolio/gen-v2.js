import {readdirSync,writeFileSync}   from 'fs'

let jsonOut = {photos:[]}

const files= readdirSync('.')

let thisGroup=1
let times=1
for (let i=1; i<files.length; i++){
    if (files[i]!="description.json" && !files[i].includes(".js")){
        if (times>=2){thisGroup=thisGroup%2+1;times=1}else{times++}
        jsonOut.photos.push(
            {
                "filename"         : files[i],
                "description"      : "",
                "hiddenDescription": "",
                "group"            : thisGroup
            }
        )
    }
}

let prettyText = JSON.stringify(jsonOut, null, "  ")

writeFileSync('description.json',prettyText)

