<template>
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
/* :root{
  --bg-color      : #010508;
  --sec-bg-color  : #0C1116;
  --font-color    : #E6EDF3;
  --sec-font-color: #858C96;
  --link-color    : #4493F8;
  --button-color  : #050b06;
  --text-box-color: #171A22;
  --filter-button-color : #21242F;
}  */
:root{
  --bg-color      : #FFFFFF; 
  --sec-bg-color  : #F4F4F4;
  --font-color    : #333333;
  --sec-font-color: #666666;
  --link-color    : black;
  --button-color  : #28A745;
  --text-box-color: #F8F9FA;
  --filter-button-color: #EAEAEA;
}

* {
  box-sizing: border-box;
}
/* https://stackoverflow.com/questions/5102820/scrolling-of-whole-page-instead-of-inner-div-only */
html, body { height: 100%; } 
html,body{
  margin    : 0px;
  top       : 0px;
  background: var(--bg-color);
  overflow-x: hidden;
}
.padding{
  height: 80px;
}
.small-padding{
  height: 10px;
}
.watermark{ 
  width:100%;
  text-align: center;
  color: var(--font-color);
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
