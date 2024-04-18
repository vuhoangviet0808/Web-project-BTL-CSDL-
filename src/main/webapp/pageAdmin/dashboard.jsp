<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard with Chart</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">--%>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.min.js"></script>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .ibox {
            margin-bottom: 20px;
            background-color: #333;
            color: white;
            padding: 20px;
            border-radius: 5px;
        }
        .ibox-body {
            position: relative;
        }
        .widget-stat-icon {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 48px;
            opacity: 0.4;
        }
        .bg-success {
            background-color: #28a745!important;
        }
        .bg-info {
            background-color: #17a2b8!important;
        }
        .bg-warning {
            background-color: #ffc107!important;
        }
        .bg-danger {
            background-color: #dc3545!important;
        }
        .color-white {
            color: #fff!important;
        }
        .m-b-5 {
            margin-bottom: 5px;
        }
        .font-strong {
            font-weight: bold;
        }
        .fa-level-up, .fa-level-down {
            margin-right: 5px;
        }
        #myChart {
            width: 100%;
            height: 400px;
        }
    </style>
    <link rel="stylesheet" href="file_js/adminPage.css">
</head>
<body>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Dashboard</h1>
    <div class="btn-toolbar mb-2 mb-md-0">

        <div class="input-group">
            <select class="custom-select">
                <option selected>Today</option>
                <option value="1">This Week</option>
                <option value="2">This Month</option>
                <option value="3">This Year</option>
            </select>
        </div>
    </div>
</div>
<div class="container pt-5">
    <div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="ibox bg-success color-white widget-stat">
                <div class="ibox-body">
                    <h2 class="m-b-5 font-strong">201</h2>
                    <div class="m-b-5">NEW ORDERS</div><i class="fa fa-shopping-cart widget-stat-icon"></i>
                    <div><i class="fa fa-level-up m-r-5"></i><small>25% higher</small></div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="ibox bg-info color-white widget-stat">
                <div class="ibox-body">
                    <h2 class="m-b-5 font-strong">1250</h2>
                    <div class="m-b-5">UNIQUE VIEWS</div><i class="fa fa-bar-chart widget-stat-icon"></i>
                    <div><i class="fa fa-level-up m-r-5"></i><small>17% higher</small></div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="ibox bg-warning color-white widget-stat">
                <div class="ibox-body">
                    <h2 class="m-b-5 font-strong">$1570</h2>
                    <div class="m-b-5">TOTAL INCOME</div><i class="fa fa-money widget-stat-icon"></i>
                    <div><i class="fa fa-level-up m-r-5"></i><small>22% higher</small></div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="ibox bg-danger color-white widget-stat">
                <div class="ibox-body">
                    <h2 class="m-b-5 font-strong">108</h2>
                    <div class="m-b-5">NEW USERS</div><i class="fa fa-user widget-stat-icon"></i>
                    <div><i class="fa fa-level-down m-r-5"></i><small>-12% Lower</small></div>
                </div>
            </div>
        </div>
    </div>
    <canvas id="myChart"></canvas>
</div>

<script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['New Orders', 'Unique Views', 'Total Income', 'New Users'],
            datasets: [{
                label: 'Statistics',
                data: [201, 1250, 1570, 108],
                backgroundColor: [
                    'rgba(40, 167, 69, 0.2)',
                    'rgba(23, 162, 184, 0.2)',
                    'rgba(255, 193, 7, 0.2)',
                    'rgba(220, 53, 69, 0.2)'
                ],
                borderColor: [
                    'rgba(40, 167, 69, 1)',
                    'rgba(23, 162, 184, 1)',
                    'rgba(255, 193, 7, 1)',
                    'rgba(220, 53, 69, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    // $(document).ready(function(){
    //     $('.date').datepicker({
    //         format: "mm/dd/yyyy",
    //         autoclose: true,
    //         todayHighlight: true
    //     });
    // });
</script>
</body>
</html>
