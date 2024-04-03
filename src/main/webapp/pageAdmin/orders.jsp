<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 01/04/2024
  Time: 10:51 CH
  To change this template use File | Settings | File Templates.
--%>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Order</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
<%--        <div class="btn-group mr-2">--%>
<%--            <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>--%>
<%--            <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>--%>
<%--        </div>--%>
        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
            <span data-feather="calendar"></span>
            This week
        </button>
        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
            <span data-feather="calendar"></span>
            All Order
        </button>
    </div>
</div>
    <div id='calendar'></div>

<script>

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth'
        });
        calendar.render();
    });

</script>




