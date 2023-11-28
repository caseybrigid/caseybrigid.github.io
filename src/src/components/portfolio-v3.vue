<template>
  <!-- Reference for format: https://www.wilhelmina.com/new-york/women/showroom-runway/7991-caroline-karwoski -->
  <div class="center">
    <div class="column">
      <div v-for="group in images" class="row">
          <div v-for="image in group">
            <img v-show="image.loaded" v-loadedifcomplete="image"
             @load="image.loaded = true"  class="img" :src="`/portfolio/${image.filename}`">
             <!-- <img v-show="!image.loaded" class="waiting"> -->
          </div>
      </div>
    </div>
  </div>  
</template>

<script>
const maxColumns           = 2
const msBetweenNextPicture = 500 //250
const fadeTime             = 1
const waitForAnimation     = 1250

// [...Array(folderSize)].map((i,j)=>j+1).reduce(
//         (arr, item, idx) => 
//         (arr[idx / columns | 0] ??= [])
//         .push(item) && arr, []),

export default{
  title: 'Main',
  directives: {
    loadedifcomplete: function(el, binding) {
       if (el.complete) {
         binding.value.loaded = true;
       }
    }
  },
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
    var r = document.querySelector(':root');
    r.style.setProperty('--fade-time', `${fadeTime}s`);
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
    let groupNumber = 0
    for (let i=0; i<numPhotos; i++){
      let group = description.photos[i]?.group
      if (i!=0 && description.photos[i]?.group!=description.photos[i-1]?.group){
        groupNumber++
      }
      if (group!=undefined){
        if (this.images[groupNumber] === undefined){
          this.images[groupNumber] = [description.photos[i]]
        }else{
          this.images[groupNumber].push(description.photos[i])
        }
      }else{
        console.log(`Image ${i} skipped due to missing group number...`)
      }
      await new Promise(res=>setTimeout(res, msBetweenNextPicture))
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
  border: 3px solid white; 
  animation: example var(--fade-time) ease;
  animation: blur calc(var(--fade-time)) steps(5, end);
}
.waiting{
  display: block;
  background: #EDEDED;
  position: relative;
  border: white;
  /* background: black; */
  width: 100%;
  height: 100%;
  border: 3px solid white; 
  animation: example var(--fade-time) ease;
  animation: blur2 calc(var(--fade-time)) steps(5, end);
}
@keyframes example {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
@keyframes blur {
  0% {
    filter: grayscale(80%) blur(.2rem);
  }
  25% {
    filter: blur(.1rem) sepia(40%) grayscale(30%);
  }
  50% {
    filter: blur(0) grayscale(30%) sepia(10%);
  }
  100% {
    filter: grayscale(0%);
  }
}
@keyframes blur2 {
  0% {
    filter: blur(.5rem) grayscale(1%);
  }
  25% {
    filter: blur(.1rem) grayscale(0%);
  }
  50% {
    filter: blur(.5rem) grayscale(1%);
  }
  100% {
    filter: grayscale(0%) blur(0);
  }
}
@media screen and (max-width: 1024px) {
  .column{
    width: 90%;
    display: grid;
    /* background: blue; */
    /* padding: 5px; */
  }
}
</style>