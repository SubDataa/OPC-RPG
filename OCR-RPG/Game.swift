//
//  Battle.swift
//  OCR-RPG
//
//  Created by Thibault on 11/09/2021.
//

import Foundation

class Game {
    
   
    var p1 = Team()
    var p2 = Team()
    
    func displayTeam(team: Team) {
        for (index,item) in team.team.enumerated() {
            print(index+1,item.categories)
        }
       
    }
    
    
    func createTeams() {
        
        // Create team 1
        print("Player 1 : Choose your characters")
        
        p1.fillTeam()
        
        //Create team 2
        print("Player 2 : Choose your characters")
        
        p2.fillTeam()
        
        // Show team
       
    
        print("Voici la composition des équipes")
        displayTeam(team: p1)
        print(p1.team[0].name)
        print("------")
        displayTeam(team: p2)
    }
    
    
    
    func battle() {
        
        while isGameOver() == false {
            //Turn Player 1
            turn(team1: p1, team2: p2)
            var end = isGameOver()
            if end == true {
                break
            }
            //Turn Player 2
            turn(team1: p2, team2: p1)
            end = isGameOver()
            if end == true {
                break
            }
            
        }
        
    }
    

    func isGameOver() -> Bool {
        if p1.team.isEmpty || p2.team.isEmpty {
         
            print("GAME OVER")
            return true
        } else {
         
            return false
        }
        
    }
    


  
   
    func fight(player1: Character, player2: Character) {
        
        let result = player1.weapon.atk - player2.weapon.atk
        if result > 0 || player2.canATK == false {
              print("\(player1.categories) : win this round")
              player2.hp = player2.hp - player1.weapon.atk
            if player2.isDead() == true  {
                print("Your character is dead")
                isGameOver()
            } else {
              print("\(player2.categories) Il vous reste \(player2.hp) PdV")
            }
          

          } else if result < 0 {
              print("\(player2.categories) : win this round")
              player1.hp = player1.hp - player2.weapon.atk
            if player1.isDead() == true {
                print("Your character is dead")
                
            } else {
                print("\(player1.categories) : Il vous reste \(player1.hp) PdV")
            }
              
          }
        
    }
    
    func heal(player: Character, team: Team){
        print("Select your character for healing")
        displayTeam(team: team)
        let selectedchartoheal = Int(readLine() ?? "0") ?? 0
        let chartoheal = team.team[selectedchartoheal - 1]
        team.team[selectedchartoheal - 1].hp = chartoheal.hp + player.weapon.atk
        print("Have healed \(chartoheal.categories)  - \(player.weapon.atk) - Current HP : \(chartoheal.hp)")
        
    }
    
    func turn(team1: Team, team2: Team){
        //Turn player 1
       print("Select your character for fight")
       displayTeam(team: team1)
       let selectedchar = (Int(readLine() ?? "0") ?? 0) - 1
       
       var char1 = team1.team[selectedchar]
      
       if char1.canATK == false {
        heal(player: char1, team: team1)
           
       } else if char1.canATK == true  {
           
           print("Select your opponent")
           displayTeam(team: team2)
           let selectedoppo = (Int(readLine() ?? "0") ?? 0) - 1
           var char2 = team2.team[selectedoppo]
           fight(player1: char1, player2: char2)
           if char1.isDead() == true {
               team1.team.remove(at: selectedchar)
           } else if char2.isDead() == true {
               team2.team.remove(at: selectedoppo)
           }

       }
    }
}



