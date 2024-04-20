class Team {
  String name = "";
  int points = 0;
  int scoredGoals = 0;
  int concededGoals = 0;
  int gamesPlayed = 0;

  Team(String name) {
    this.name = name;
    this. points = 0;
    this.scoredGoals = 0;
    this.concededGoals = 0;
    this.gamesPlayed = 0;
  }

  @override
  String toString() {
    return 'Team{name: $name, points: $points, scoredGoals: $scoredGoals, concededGoals: $concededGoals, gamesPLayed: $gamesPlayed}';
  }
}