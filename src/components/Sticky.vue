<template>
  <v-hover v-slot:default="{ hover }">
    <v-card :id="id" class="pa-0 ma-0 border-0" color="transparent" outlined>
      <v-container style="position: absolute; z-index: 1" align-content-end class="pa-0 ma-0 border-0 pr-1">
        <v-btn
          dark
          color="grey darken-1"
          v-if="hover"
          x-small
          icon
          class="mt-2 float-right"
          alt="Remove sticky"
          v-on:click="emitRemoveMe($event)"
        >
          <v-icon>mdi-delete-forever</v-icon>
        </v-btn>
      </v-container>
      <v-fade-transition>  
      <v-textarea 
      :value="text"
      :background-color="color"
      label="Add your text here..."
      rows="5"
      solo
      auto-grow >
      </v-textarea>
      </v-fade-transition>   
    </v-card>
  </v-hover>
</template>

<script lang="ts">
  import Vue from "vue"
  export default Vue.extend({
    props: {
      id: {
        type: String
      },
      text: {
        type: String,
        default: "Lorem ipsum dolor sit amet",
      },
      color: {
        type: String,
        default: "#FFF",
      }
    },
    methods: {
      emitRemoveMe: function() {
        this.$emit("remove-me", this.id)
      }
    }
  });
</script>

<style scoped>
  .v-card {
    min-width: 240px;
  }
</style>