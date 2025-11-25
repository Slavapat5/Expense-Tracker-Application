// app/javascript/controllers/dashboard_chart_controller.js
import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

export default class extends Controller {
  static targets = ["pieCanvas", "lineCanvas"]

  static values = {
    categoryLabels: Array,
    categoryData: Array,
    monthLabels: Array,
    monthData: Array
  }

  connect() {
    this.renderPieChart()
    this.renderLineChart()
  }

  renderPieChart() {
    if (!this.hasPieCanvasTarget) return

    const ctx = this.pieCanvasTarget.getContext("2d")

    // Destroy old chart if it exists
    if (this.pieChart) this.pieChart.destroy()

    this.pieChart = new Chart(ctx, {
      type: "pie",
      data: {
        labels: this.categoryLabelsValue,
        datasets: [
          {
            data: this.categoryDataValue
          }
        ]
      }
    })
  }

  renderLineChart() {
    if (!this.hasLineCanvasTarget) return

    const ctx = this.lineCanvasTarget.getContext("2d")

    if (this.lineChart) this.lineChart.destroy()

    this.lineChart = new Chart(ctx, {
      type: "line",
      data: {
        labels: this.monthLabelsValue,
        datasets: [
          {
            label: "Monthly Spending",
            data: this.monthDataValue
          }
        ]
      }
    })
  }
}
