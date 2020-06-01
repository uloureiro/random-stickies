<template>
  <v-card class="pa-2 ma-2 text--ligthen-2" elevation="3" style="min-height: 120px; min-width:250px" :color="color">
    {{ text }}
  </v-card>
</template>

<script lang="ts">
  import Vue from "vue"
  export default Vue.extend({
    props: {
      text: {
        type: String,
        default: "Lorem ipsum dolor sit amet",
      },
      color: {
        type: String,
        default: "#FFF",
      }
    },
    data: () => {
      let text = "Lorem ipsum dolor sit amet"
      let color = "#FFF"
      return { text, color }
    }
  });
</script>