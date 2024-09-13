<template>
    <div class="message">Group By Column, Same Color Next to Each Other Same Column, Pls make four columns</div>
    <div class="center"> 
      <div class="column">
        <draggable class="row" group="people" v-model="images" @start="drag=true" @end="drag=false" item-key="id">
          <template #item="{element}">
            <div class="title"><img class="img" :src="`/portfolio/img/${element.filename}`"
              :class="{ 'group1':  element.group==1, 'group2': element.group==2 }"
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
      // Get the description file 
      let noCacheRequest = new Headers()
        noCacheRequest.append('pragma', 'no-cache')
        noCacheRequest.append('cache-control', 'no-cache')
        const extras  = { method: 'GET', headers: noCacheRequest}
        const content = new Request('/portfolio/description.json')
      const res             = await fetch(content, extras)
      const description     = await res.json()
      const numPhotos       = description.photos.length

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
        const link = document.createElement("a")
        link.download = "description.json"
        link.href = window.URL.createObjectURL(blob)
        link.click()
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
  .message{
    padding    : 5px;
    text-align : center;
  }
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
  .group3{
    background: rgba(0, 255, 47, 0.4);
  }
  .group4{
    background: rgba(255, 0, 208, 0.4);
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
    grid-template-columns: repeat(auto-fit, minmax(10%, 1fr));
  }

</style>