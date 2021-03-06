<%@include file="includes/header.jsp" %>

<div ng-controller="teamProfile" ng-init="init('${team.id}')">
  <div class="jumbotron">
    <div class="row">
      <div class="col-md-10">
        <h1>
          <small>Team</small><br>
          <span class="teamStyle">{{ team.name }}</span>
        </h1>
      </div>

      <div class="col-md-2 text-right">
        <div class="btn-group" ng-show="isMember()">
          <button class="btn btn-material-pink dropdown-toggle" data-toggle="dropdown">
            Settings
            <span class="caret"></span>
          </button>
          <ul class="dropdown-menu dropdown-menu-material-pink" role="menu">
            <li ng-hide="isLeader()"><a href="../../teams/{{team.id}}/leave">Leave Team</a></li>
            <li ng-show="isLeader()"><a href="#">Edit Team</a></li>
            <li ng-show="isLeader()"><a href="../../teams/{{team.id}}/delete">Delete Team</a></li>
          </ul>
        </div>
        <a href="../../teams/{{team.id}}/join">
          <button type="button" class="btn btn-material-pink" ng-show="!isMember()">Join Team</button>
        </a>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4">
        <h2>
          <small>Leader</small><br>
          <a href="../../users/{{team.leader}}">
            {{ team.leaderName }} {{ team.leaderSurname }}
          </a>
        </h2>
      </div>

      <div class="col-md-4">
        <div class="panel panel-material-lightblue">
          <div class="panel-heading">
            <h3 class="panel-title">
              Events <span class="badge">{{team.events.length}}</span>
            </h3>
          </div>
          <div class="panel-body">
            <h4 ng-repeat="event in team.eventsData">
              <a href="../../events/{{event.id}}">
                <span class="eventStyle"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                {{ event.name }}</span>
              </a>
            </h4>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="panel panel-material-teal">
          <div class="panel-heading">
            <h3 class="panel-title">
              Members <span class="badge">{{team.members.length}}</span>
            </h3>
          </div>
          <div class="panel-body">
            <h4 ng-repeat="member in team.membersData">
              <a href="../../users/{{member.id}}">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                {{ member.name }} {{ member.surname }}
              </a>
            </h4>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>
<%@include file="includes/footer.jsp" %>