<template>
  <!-- Reference for format: https://www.wilhelmina.com/new-york/women/showroom-runway/7991-caroline-karwoski -->
      <!-- <div class="view"> -->

        <!-- <div class="center"> 
          <div class="edit">
            <draggable class="group" v-for="item,groupNumber in images.length" v-model="images[groupNumber]" group="people"  @start="drag=true" @end="drag=false" item-key="id">
              <template #item="{element}">
                  <div class="title description">
                    <div>{{element.filename}}</div>
                     <img  class="img" :src="`portfolio/${element.filename}`"> 
                  </div>
              </template>
            </draggable>
          </div>
        </div>  -->

        <div class="center"> 
              <div class="column">
                <draggable class="row group" v-for="item,groupNumber in images.length" v-model="images[groupNumber]" group="people"  @start="drag=true" @end="drag=false" item-key="id">
                  <template #item="{element}">
                    <div class="title"><img class="img" :src="`portfolio/${element.filename}`"></div>
                  </template>
                </draggable>
              </div>
        </div>

        <!-- <div class="center"> 
          <div class="edit">
            <div class="center"> 
              <div class="column">
                <div v-for="group in images" class="row">
                    <img v-for="image in group" class="img" :src="`portfolio/${image.filename}`">
                </div>
              </div>
            </div>
          </div>
        </div> -->
        
    <!-- </div> -->
    <div class="center"> 
      <button class="save" @click="out">Save</button>
    </div>
</template>
  
  <script>
  import draggable from 'vuedraggable'

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
    components : { draggable } ,
    data(){
      return {
        images: [],
        show: false,
        drag: false
      }
    },
    async mounted(){   
      //await this.updateColumns();
      // Allow animations to show before requesting all the images and slowing stuff down
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
        let groupNumber = description.photos[i]?.group-1                    // Account for starting from 1
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
    },
    methods:{

      async out(){
        let description = {"photos": []}
        // reformat to export
        for (let groupNumber=0;groupNumber<this.images.length;groupNumber++){
          // Relabel and add to description.json
          for (let image=0; image<this.images[groupNumber].length;image++){
            let imageData = this.images[groupNumber][image]
            imageData.group = groupNumber+1
            description.photos.push(imageData)
          }
        }
        // Export all pretty
        const blob = new Blob([JSON.stringify(description,null, 2)])
        // To downloads folder
        // const link = document.createElement("a")
        // link.download = "description.json"
        // link.href = window.URL.createObjectURL(blob)
        // link.click()
        // Pick Folder
        const supportsFileSystemAccess = 'showSaveFilePicker' in window && (() => {
          try {
            return window.self === window.top;
          } catch {
            return false;
          }
        })()
        if (supportsFileSystemAccess) {
          try {
            const handle = await showSaveFilePicker({suggestedName: "description.json"})  // Show the file save dialog.
            const writable = await handle.createWritable();
            await writable.write(blob);
            await writable.close();
            return
          } catch (err) {
            if (err.name !== 'AbortError') {
              console.error(err.name, err.message)
              return
            }
          }
        }
      },

    },
    computed: {
      range(start, end){
        console.log('here')
        const length = end - start;
        return Array.from({ length }, (_, i) => start + i);
      }
    }
  }
</script>
  
  <style scoped>
  .save{
    width: 80px;
    border-radius: 5px;
    background: rgb(48,48,48);
    color: whitesmoke;
  }
  .save:hover{
    opacity: .8;
  }
 .view{
  display: grid;
  grid-template-columns: 50% 50%;
 }
  .edit{
    width: 300px;
    height: 55vh;
    overflow: scroll;
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    background: rgb(48,48,48);
  }
  .group{
    background: rgb(48,48,48);
    padding: 5px;
    border: 1px solid white;
    min-height: 100px;
  }
  .title{
    background: lightgray;
    border-radius: 5px;
    margin:25px;
    padding: 5px;
  }
  .description{
    display: grid;
    grid-template-columns: 25% 50%;
  }
  .title:hover{
    opacity: .8;
  }
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