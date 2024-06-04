import {readdirSync,writeFileSync}   from 'fs'

let jsonOut = {photos:[]}

const files= readdirSync('src/public/portfolio/img')

let thisGroup=1
let times=1
for (let i=0; i<files.length; i++){
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

writeFileSync('src/public/portfolio/description.json',prettyText)

