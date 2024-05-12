import 'package:league_manager/other/Team.dart';
import 'package:league_manager/other/Match.dart';
import 'package:league_manager/other/Matchday.dart';

class MatchScheduler {
  List<Matchday> generateMatchdays(List<Team> teams) {
    int numberOfTeams = teams.length;

    if (numberOfTeams < 2) {
      throw ArgumentError('At least two teams are needed to create matchdays');
    }

    // If there's an odd number of teams, add a "bye" team to ensure an even count
    List<Team> effectiveTeams = List.from(teams);
    effectiveTeams.shuffle();
    if (numberOfTeams % 2 != 0) {
      effectiveTeams.add(Team("Bye"));
      numberOfTeams += 1;
    }

    int half = numberOfTeams ~/ 2;
    int rounds = numberOfTeams - 1;

    List<Matchday> matchdays = [];

    // Create initial matchdays
    for (int round = 0; round < rounds; round++) {
      List<Match> matches = [];

      for (int i = 0; i < half; i++) {
        int homeIndex = (round + i) % (numberOfTeams - 1);
        int awayIndex = (numberOfTeams - 1 - i + round) % (numberOfTeams - 1);

        if (i == 0) {
          awayIndex = numberOfTeams - 1;
        }

        Team homeTeam = effectiveTeams[homeIndex];
        Team awayTeam = effectiveTeams[awayIndex];

        if (homeTeam.name != "Bye" && awayTeam.name != "Bye" && homeTeam != awayTeam) {
          matches.add(Match(homeTeam, awayTeam));
        }
      }

      matchdays.add(Matchday(round + 1, matches));
    }

    return matchdays;
  }

  List<Matchday> generateInvertedMatchdays(List<Matchday> originalMatchdays) {
    List<Matchday> invertedMatchdays = [];

    for (var matchday in originalMatchdays) {
      List<Match> invertedMatches = [];

      for (var match in matchday.matches) {
        invertedMatches.add(Match(match.awayTeam, match.homeTeam));
      }

      int newDayNumber = matchday.dayNumber + originalMatchdays.length;
      invertedMatchdays.add(Matchday(newDayNumber, invertedMatches));
    }

    return invertedMatchdays;
  }
}