<template>
  <!-- Reference for format: https://www.wilhelmina.com/new-york/women/showroom-runway/7991-caroline-karwoski -->
        <div class="center"> 
              <div class="column">
                <draggable class="row" group="people" v-model="images" @start="drag=true" @end="drag=false" item-key="id">
                  <template #item="{element}">
                    <div class="title"><img class="img" :src="`portfolio/${element.filename}`"
                      :class="{ 'group1':  element.group==2, 'group2': element.group==1 }"
                      @click="element.group=element.group%2+1"></div>
                  </template>
                </draggable>
              </div>
        </div>

        
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
        this.images.push(description.photos[i])
      }
      
    },
    methods:{

      async out(){
        let description = {"photos": []}
        // reformat to export
        for (let img=0;img<this.images.length;img++){
            let imageData = this.images[img]
            description.photos.push(imageData)
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
  .img{
    position: relative;
    /* background: black; */
    height: 100%;
    width: 100%;
    padding: 5px;
    border: 1px solid white;
    object-fit: cover;
    /* border: 1px solid white;  */
  }
  img:hover{
    opacity: .8;
  }
  .group1{
    background: rgba(255, 0, 0,.4);
  }
  .group2{
    background: rgba(0, 0, 255, .4);
  }
  .center{
    width: 100%;
    display: grid;
    justify-items: center;
  }
  .row{
    width: 100%;
    display: grid;
    /* background: grey; */
    /* padding: 5px; */
    grid-template-columns: repeat(auto-fit, minmax(25%, 1fr));
  }

</style>