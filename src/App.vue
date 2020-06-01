<template>
  <v-app>
    <v-content>
      <Board />
    </v-content>
    <v-footer dark padless fixed>
      <v-row justify="center" no-gutters>
        <v-col class="py-4 text-center" cols="12">
          {{ new Date().getFullYear() }} —
          <strong>Random Stickies</strong>
        </v-col>
      </v-row>
    </v-footer>
  </v-app>
</template>

<script>
import Board from "./components/Board";

export default {
  name: "App",
  components: {
    Board
  }
};
</script>

<style>
  html { overflow-y: auto }
</style>