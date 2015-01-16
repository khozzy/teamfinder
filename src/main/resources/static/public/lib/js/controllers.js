suspyApp

    
    .controller('MainController',function ($scope,$document) {
})
    .controller('HomeController', function() {

})
    .controller('FriendsController', function() {

})
    .controller('ErrorCtrl', function($scope) {


})
    .controller('homeAdvisorCtrl', function($scope){

            //carusel
            $scope.myInterval1 = 3000;
            $scope.myInterval2 = 2000;
            $scope.myInterval3 = 2500;
        

            var slides1 = $scope.slides1 = [];
            var slides2 = $scope.slides2 = [];
            var slides3 = $scope.slides3 = [];

            $scope.addSlides = function() {
                slides1.push({
                    image: '/public/lib/assets/stadium' + slides1.length + '.jpg'
                });
                slides2.push({
                    image: '/public/lib/assets/pool' + slides2.length + '.jpg'
                });
                slides3.push({
                    image: '/public/lib/assets/voley' + slides3.length + '.jpg'
                });
            };
        
            for (var i=0; i<3; i++) {
                $scope.addSlides();
            }
        
    })

    .controller('teamsManage', function($scope, $http) {
        function getTeams() {
            $http.get('/service/teams/my').success(function(result) {
                $scope.teams = result;

                angular.forEach($scope.teams, function (team) {
                    team.memberNames = [];
                    angular.forEach(team.members, function (member) {
                        $http.get('/service/users/' + member).success(function (user) {
                            team.memberNames.push(user);
                        })
                    })
                })
                console.log($scope.teams);
            })
        }
        getTeams();
    })

    .controller('teamProfile', function($scope, $http) {

        var isMemberBool = false;
        var isLeaderBool = false;

        $scope.init = function(teamID) {
            $scope.teamID = teamID;
            $http.get('/service/teams/' + teamID).success(function (result) {
                $scope.team = result;

                // Get leader name and surname
                $http.get('/service/users/' + $scope.team.leader).success(function(result) {
                    $scope.team.leaderName = result.name;
                    $scope.team.leaderSurname = result.surname;
                })

                // Get members names and surnames
                angular.forEach($scope.team.members, function(member) {
                    $scope.team.membersData = [];
                    $http.get('/service/users/' + member).success(function(result) {
                        $scope.team.membersData.push(result);
                    })
                })

                // Get events of the team
                angular.forEach($scope.team.events, function(event) {
                    $scope.team.eventsData = [];
                    $http.get('/service/events/' + event).success(function(result) {
                        $scope.team.eventsData.push(result);
                    })
                })

                $http.get('/service/users/current').success(function (result) {
                    // Determine if the current user is member of the team
                    if ($scope.team.members.indexOf(result.id) != -1) {
                        isMemberBool = true;
                    }

                    // Determine if the current user is leader of the team
                    if (result.id == $scope.team.leader) {
                        isLeaderBool = true;
                    }
                })
            })
        }

        $scope.isMember = function() {
            return isMemberBool;
        }

        $scope.isLeader = function() {
            return isLeaderBool;
        }
    })

    .controller('newPlace', function ($scope, $http) {
        $scope.today = function() {
            $scope.dt = new Date();
        };
        $scope.today();

        $scope.clear = function () {
            $scope.dt = null;
        };

        $scope.open = function($event , opened) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope[opened] = true;
        };

        $scope.dateOptions = {
            formatYear: 'yy',
            startingDay: 1
        };

        $scope.format = 'dd/MM/yyyy';


        
        $scope.getLocation = function(val) {
            return $http.get('http://maps.googleapis.com/maps/api/geocode/json', {
                // Any function returning a promise object can be used to load values asynchronously
                params: {
                    address: val,
                    sensor: false
                }
            }).then(function(response){
                return response.data.results.map(function(item){
                    return item.formatted_address;
                });
            });
        };
    })

    .controller('placeCtrl', function($scope,$http){

        
        //carusel
        $scope.myInterval = 5000;
        
        var slides = $scope.slides = [];
        
        $scope.addSlide = function() {
            slides.push({
                image: '/public/lib/assets/stadium' + slides.length + '.jpg'
            });
        };
        for (var i=0; i<3; i++) {
            $scope.addSlide();
        }
        
        
        $scope.init = function(placeID) {
            $scope.placeID = placeID;
            $scope.timeSlot = [];
            $http.get('/service/places/' + placeID)
                .success(function (place) {
                    $scope.place = place;

                    
                    $http.get('/service/users/' + $scope.place.owner)
                        .success(function(owner){
                            
                            $scope.place.owner = owner;
                            
                        });
                    
                    angular.forEach($scope.place.timeSlots ,function(item){
                        
                        
                        $http.get('/service/timeslots/' + item)
                            .success(function (timeSlots) {
                                $http.get('/service/events/' + timeSlots.event)
                                    .success(function(event) {

                                        timeSlots.event = event;
                                        $scope.timeSlot.push(timeSlots);
                                        
                                        //console.log(event);
                                        //console.log(angular.toJson($scope.place));
                                        //console.log(angular.toJson(timeSlot[0]));
                                        //console.log(timeSlot[1]);
                                        console.log($scope.timeSlot);
                                    })

                            })
                    
                    });



                })
        }
    })

    .controller('manageEvents', function($scope, $http){
      

        //I imagine it could be done better :)
        function getEvents () {
            $http.get('/service/events/all')
                .success(function(result) {
                    $scope.events = result;
                    
                    angular.forEach( $scope.events , function (item) {
                       
                        $http.get('/service/timeslots/' + item.timeSlot)
                            .success(function(timeSlot) {

                                $http.get('/service/places/' + timeSlot.place)
                                    .success(function(place) {
                                        
                                        timeSlot.place = place;
                                        item.timeSlot = timeSlot;

                                    })
                                    .error(function(data){
                                        console.log(data); 
                                    });
                            
                            })
                            .error(function(data){
                                console.log(data); 
                            });

                        $http.get('/service/users/' + item.organizer)
                            .success(function(user) {
                                
                                item.organizer = user;

                            })
                            .error(function(data){
                                console.log(data);
                            });

                        
                    });
                    //console.log($scope.events);
                })
                .error(function(data){
                    console.log(data); 
                });
            
        }

        
        getEvents();




    })

    
    .controller('newEventController', function($scope, $http, $document) {

        getPlaces();
        
        

        $scope.addNewEvent = function() {

            
            var newEvent = {
                deleted : false,
                name : $scope.eventName,
                details : $scope.eventDetails,
                timeSlot : $scope.eventTime.id,
                team : null,
                priv : false
            };

            console.log(newEvent);
            $http.post('/service/events/addNew', newEvent)
                .success(function (result) {
                    console.log(result);
                    
                })
                .error(function (data) {
                    console.log(data); //print out error to the log
                });
            
            $scope.eventName = '';
            $scope.eventDetails = '';
            $scope.eventPlace = '';
            $scope.eventTime = '';
        };
        
        $scope.updateTimeslots = function() {
            $http.get('/service/timeslots/place/' + $scope.eventPlace.id)
                .success(function (data) {
                    $scope.timeslots = data;
                })
                .error(function (data) {
                    console.log("Error when fetching places for creating new event")
                });
        };

        $scope.stripeCallback = function (code, result) {
            console.log("stripe callback");

            if (result.error) {
                console.log('it failed! error: ' + result.error.message);
            } else {
                console.log('success! token: ' + result.id);
            }
        };



        function getPlaces() {
            $http.get('/service/places/all')
                .success(function (data) {
                    $scope.places = data;
                })
                .error(function (data) {
                    console.log("Error when fetching places for creating new event")
                });
        }


})
    .controller('SearchController', function($scope,$http,$document,hotkeys) {
        $scope.form='';
        $scope.form = {
            query: '',
            selection: 'events',
            pageNum : 0,
            numOfResults : 10
        };
        var searchInput = angular.element('#searchInput');
        $scope.$watchCollection('form', function() {
            $scope.progressBarVal = 0;
            if ($scope.form.query != undefined && $scope.form.query !='') {
                $scope.results = 'Loading...';
                $http.get('/service/' + $scope.form.selection,
                    {params: {
                        query: $scope.form.query,
                        pageNum: $scope.form.pageNum,
                        numOfResults: $scope.form.numOfResults
                    }})
                    .success(function (data) {
                        if(data.numberOfElements!=0) {
                            $scope.results = data.content;
                            switch($scope.form.selection) {
                                case 'events':
                                    $scope.progressBarVal += 1/4*100;
                                    $scope.getOrganizers();
                                    $scope.getTimeSlots();
                                    break;
                                case 'places':
                                    $scope.progressBarVal += 1/2*100;
                                    $scope.getOwners();
                                    break;
                                case 'teams':
                                    break;
                            }
                            $document.duScrollToElementAnimated(searchInput);
                        }
                        else{
                            $scope.results = '';
                            $scope.progressBarVal = 100;

                        }
                    })
                    .error(function (data) {
                        $scope.results = '';
                        $scope.progressBarVal = 100;
                    });

            }
            else if($scope.form.query ==''){$document.duScrollTopAnimated(0);}

            
        });

        $scope.getOwners = function() {

            for (index = 0; index < $scope.results.length; ++index) {
                (function(i) {
                    var userId = $scope.results[i].owner;
                    $http.get('/service/users/' + userId)
                        .success(function (data) {
                            $scope.results[i].owner=
                            {
                                id:userId, 
                                name:data.name + ' ' +data.surname
                            };
                            $scope.progressBarVal += 1/($scope.results.length*2)*100;
                        })
                        .error(function (data) {
                            $scope.results[i].owner=
                            {
                                id:userId, 
                                name:'Not found'
                            };
                            $scope.progressBarVal += 1/($scope.results.length*2)*100;
                        });
                })(index);
            }
            
        };

        
        //wiem że dublowanie ale nie chce mi sie przerabiać
        $scope.getOrganizers = function() {

            for (index = 0; index < $scope.results.length; ++index) {
                (function(i) {
                    var userId = $scope.results[i].organizer;
                    $http.get('/service/users/' + userId)
                        .success(function (data) {
                            $scope.results[i].organizer=
                            {
                                id:userId, 
                                name:data.name + ' ' +data.surname
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        })
                        .error(function (data) {
                            $scope.results[i].organizer=
                            {
                                id:userId, 
                                name:'Not found'
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        });
                })(index);
            }

        };

        $scope.getTimeSlots = function() {

            for (index = 0; index < $scope.results.length; ++index) {
                (function(i) {
                    var timeSlotId = $scope.results[i].timeSlot;
                    $http.get('/service/timeslots/' + timeSlotId)
                        .success(function (data) {
                            $scope.results[i].timeSlot=
                            {
                                id:timeSlotId,
                                place: data.place,
                                from: data.from,
                                to: data.to
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                            $scope.getPlace(i);
                        })
                        .error(function (data) {
                            $scope.results[i].timeSlot=
                            {
                                id:timeSlotId,
                                place:'Not found',
                                from: 'Not found',
                                to: 'Not found'
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        });
                })(index);
            }

        };

        $scope.getTimeSlotsForPlaces = function() {

            for (index = 0; index < $scope.results.length; ++index) {
                (function(i) {
                    var timeSlotId = $scope.results[i].timeSlot;
                    $http.get('/service/timeslots/' + timeSlotId)
                        .success(function (data) {
                            $scope.results[i].timeSlot=
                            {
                                id:timeSlotId,
                                place: data.place,
                                from: data.from,
                                to: data.to
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                            $scope.getPlace(i);
                        })
                        .error(function (data) {
                            $scope.results[i].timeSlot=
                            {
                                id:timeSlotId,
                                place:'Not found',
                                from: 'Not found',
                                to: 'Not found'
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        });
                })(index);
            }

        };

        $scope.getPlace = function(index) {
                (function(i) {
                    var placeId = $scope.results[i].timeSlot.place;
                    
                    $http.get('/service/places/' + placeId)
                        .success(function (data) {
                            $scope.results[i].timeSlot.place=
                            {
                                id: placeId,
                                name: data.name
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        })
                        .error(function (data) {
                            $scope.results[i].timeSlot.place=
                            {
                                id: placeId,
                                name: 'Not found'
                            };
                            $scope.progressBarVal += 1/($scope.results.length*4)*100;
                        });
                })(index);

        };
        
        $scope.round = function(value){
            
            return Math.round(value);
            
        };
        
        $scope.searchButtons = function(){
            angular.element('#eventsLabel').removeClass('shadow-z-5');
            angular.element('#placesLabel').removeClass('shadow-z-5');
            angular.element('#teamsLabel').removeClass('shadow-z-5');
            angular.element('#searchInput').removeClass('form-control-material-cyan');
            angular.element('#searchInput').removeClass('form-control-material-orange');
            angular.element('#searchInput').removeClass('form-control-material-pink');
            switch($scope.form.selection){
                case 'events':
                    $scope.materialColour = 'cyan';
                    angular.element('#eventsLabel').addClass('shadow-z-5');
                    angular.element('#searchInput').addClass('form-control-material-cyan');
                    break;
                case 'places':
                    $scope.materialColour = 'orange';
                    angular.element('#placesLabel').addClass('shadow-z-5');
                    angular.element('#searchInput').addClass('form-control-material-orange');
                    break;
                case 'teams':
                    $scope.materialColour = 'pink';
                    angular.element('#teamsLabel').addClass('shadow-z-5');
                    angular.element('#searchInput').addClass('form-control-material-pink');
                    break;
            }

        };


        hotkeys.bindTo($scope)
            .add({
                combo: 'right',
                description: 'Changes form selection',
                allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                callback: function() {
                    switch($scope.form.selection){
                        case 'events':
                            $scope.form.selection = 'places';
                            break;
                        case 'places':
                            $scope.form.selection = 'teams';
                            break;
                        case 'teams':
                            $scope.form.selection = 'events';
                            break;
                    }
                    $scope.searchButtons();
                }
            });
        
        hotkeys.bindTo($scope)
            .add({
                combo: 'left',
                description: 'Changes form selection',
                allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                callback: function(){
                    switch ($scope.form.selection) {
                        case 'events':
                            $scope.form.selection = 'teams';
                            break;
                        case 'places':
                            $scope.form.selection = 'events';
                            break;
                        case 'teams':
                            $scope.form.selection = 'places';
                            break;
                    }
                    $scope.searchButtons();
                }
            });

    });