import {writeFileSync} from "fs"

let jsonOut = {photos:[]}
for (let i=1; i<32; i++){
    jsonOut.photos.push(
        {
            "filename"         : `${i}.JPG`,
            "description"      : "",
            "hiddenDescription": ""
        }
    )
}

let prettyText = JSON.stringify(jsonOut, null, "  ")

writeFileSync('description.json',prettyText)