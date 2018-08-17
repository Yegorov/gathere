import {Project} from "../../../app/javascript/packs/project.js"
import {ProjectTable} from "../../../app/javascript/packs/project_table.js"

$(() => {
  if ($(".task-table").length > 0) {
    const element = $(".task-table")
    const project = new Project(element.data("project"))
    project.load().then(() => {
      const table = new ProjectTable(project, ".task-table")
      table.insert()
    })
  }
})
