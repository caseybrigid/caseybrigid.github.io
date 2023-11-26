<template>
  <!-- Reference for format: https://www.wilhelmina.com/new-york/women/showroom-runway/7991-caroline-karwoski -->
  <div class="center">
    <div class="column">
      <div v-for="group in images" class="row">
          <img v-for="image in group" class="img" :src="`portfolio/${image.filename}`">
      </div>
    </div>
</div>
</template>

<script>
const maxColumns           = 2
const msBetweenNextPicture = 250
const fadeTime             = 1
const waitForAnimation     = 250

// [...Array(folderSize)].map((i,j)=>j+1).reduce(
//         (arr, item, idx) => 
//         (arr[idx / columns | 0] ??= [])
//         .push(item) && arr, []),

export default{
  title: 'Main',
  data(){
    return {
      images: [],
      show: false
    }
  },
  async mounted(){   
    //await this.updateColumns();
    // Allow animations to show before requesting all the images and slowing stuff down
    console.log("here")
    await new Promise(res=>setTimeout(res, waitForAnimation))
    // Get the description file 
    let noCacheRequest = new Headers()
      noCacheRequest.append('pragma', 'no-cache')
      noCacheRequest.append('cache-control', 'no-cache')
      const extras  = { method: 'GET', headers: noCacheRequest}
      const content = new Request('/portfolio/description.json')
    const res             = await fetch(content, extras)
    const description     = await res.json()
    const numPhotos       = description.photos.length
    // Load photo data into variables
    const photosPerColumn = Math.ceil(numPhotos/maxColumns)
    this.show=true

    // Loop through items adding new groups when neccesasary 
    for (let i=0; i<numPhotos; i++){
      let groupNumber = description.photos[i]?.group
      if (groupNumber!=undefined){
        if (this.images[groupNumber] === undefined){
          this.images[groupNumber] = [description.photos[i]]
        }else{
          this.images[groupNumber].push(description.photos[i])
        }
      }else{
        console.log(`Image ${i} skipped due to missing group number...`)
      }
    }
  }
}
</script>

<style scoped>
.center{
  width: 100%;
  display: grid;
  justify-items: center;
}
.column{
	width: 50%;
	display: grid;
  /* background: blue; */
  /* padding: 5px; */
}
.row{
	width: 100%;
	display: grid;
  /* background: grey; */
  /* padding: 5px; */
  grid-template-columns: repeat(auto-fit, minmax(25%, 1fr));
}
.img{
  position: relative;
  /* background: black; */
  width: 100%;
  height: 100%;
  /* border: 1px solid white;  */
}
</style>