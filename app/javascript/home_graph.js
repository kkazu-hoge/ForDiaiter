$(document).on('turbolinks:load', function() {
  const ctx = document.getElementById('myChart').getContext('2d');
  const myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ["a", "b", "c", "d", "e"],
        datasets: [{
            label: "計画消費カロリー",
            data: [10, 20, 30, 40, 50],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 3,
            tension: 0.4
        },
        {
            label: '実績消費カロリー',
            data: [-10, -15],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 3,
            tension: 0.4
        }]
    },
    options: {
      responsive: true,
      // plugins: {
      //   title: {
      //     display: true,
      //     text: '7日間の投稿数の比較'
      //   }
      // },
      scales: {
        y: {
          suggestedMin: 0,
          suggestedMax: 100,
          ticks: {
            stepSize: 5
          }
        }
      },
    }
  });
});