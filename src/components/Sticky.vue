<template>
  <v-card class="pa-0 ma-0 border-0" color="transparent" outlined>
    <v-textarea 
    :value="text"
    :background-color="color"
    label="Add your text here..."
    rows="5"
    solo
    auto-grow >
    </v-textarea>
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

<style scoped>
  .v-card {
    min-width: 240px;
  }
</style>