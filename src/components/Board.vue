<template>
  <v-content dark>
    <v-toolbar dark>
      <v-spacer></v-spacer>
      <v-toolbar-title display-1>
        <div class="display-1 font-weight-thin" style="border: none" contenteditable>
          {{ name }}
        </div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn fab color="grey darken-3" right bottom absolute @click="addLane">
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </v-toolbar>
    <v-container fluid class="grey" style="min-height:calc(100vh - 120px);">
      <v-row>
        <v-col v-for="lane in lanes" :key="lane.id" style="min-height:calc(100vh - 160px);">
          <Lane :id="lane.id" :name="lane.name" :color="lane.color" v-on:remove-me="removeLane"/>
        </v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<script lang="ts">
import Vue from "vue";
import Lane from "./Lane";
import { v4 as uuidv4 } from "uuid";

export default Vue.extend({
  components: { Lane },
  data: () => {
    let name = "My board";
    let lanes = new Array(
      { id: uuidv4() },
      { id: uuidv4() },
      { id: uuidv4(), color: "#789789" }
    );
    return { name, lanes };
  },
  methods: {
    addLane: function() {
      this.lanes.push({ id: uuidv4(), name: "New lane" });
    },
    removeLane: function(id) {
      let index = this.lanes.findIndex(function(el) {
        return el.id == id;
      });
      if (index >= 0) {
        this.lanes.splice(index, 1);
      }
    }
  }
});
</script>

<style scoped>
.v-toolbar__title {
  cursor: pointer;
}
[contenteditable]:focus {
    outline: 0px solid transparent;
}
</style>