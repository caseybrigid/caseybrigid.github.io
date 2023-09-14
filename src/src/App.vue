<template>
  <!-- credits to inspiration for style: https://www.amy-lily.com -->
  <navbar/>
  <router-view></router-view>
  <div class="padding"></div>
  <div class="watermark">Made with ❤️ by my boyfriend</div>
  <div class="small-padding"></div>
</template>

<script>
import navbar from './components/navbar.vue'
export default{
  components: {navbar},
  title : ""
}
</script>

<style>
* {
  box-sizing: border-box;
}
/* https://stackoverflow.com/questions/5102820/scrolling-of-whole-page-instead-of-inner-div-only */
html, body { height: 100% } 
html,body{
  margin    : 0px;
  top       : 0px;
  background: white;
  overflow-x: hidden;
}
.padding{
  height: 40px;
}
.small-padding{
  height: 10px;
}
.watermark{
  width:100%;
  text-align: center;
  color: black;
  opacity: .45;
        font-size: 16px;
        font-family: lato, sans-serif;
        font-weight: 400;
        text-transform: uppercase;
        letter-spacing: .05rem;
        text-align: center;
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
</style>
