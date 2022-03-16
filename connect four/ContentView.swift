//
//  ContentView.swift
//  connect four
//
//  Created by User02 on 2022/3/9.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
    @State private var boards = Array(repeating: Array(repeating: board_state.blank, count: 6), count: 7 )
    @State private var now_turn = Turn.yellow
    @State private var game_state = gameState.draw
    @State private var chess_pos=0
    @State private var win_pos = [[0]]
    @State private var red_win  = 0
    @State private var yellow_win = 0
    @State private var red_remain=21
    @State private var yellow_remain=21
    
    //music,soundtrack
    var chessPlayer : AVPlayer {AVPlayer.sharedChessPlayer }
    var BGMPlayer : AVPlayer {AVPlayer.sharedBGMPlayer }
    //timer
    @State private var round_time=15
    var round_timer:Timer?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack{
            
            HStack{
                VStack{
                    Text("Player Red")
                        .foregroundColor(Color.red)
                        .padding(.trailing)
                    Text("\(red_win) win")
                        .padding(.trailing)
                    Text("remain : \(red_remain)")
                        .padding(.trailing)
                    
                }
                
                VStack{
                    Text("Player Yellow")
                        .foregroundColor(Color.yellow)
                        .padding(.leading)
                    Text("\(yellow_win) win")
                        .padding(.leading)
                    Text("remain : \(yellow_remain)")
                        .padding(.leading)
                }
                
            }
            
            HStack{
                ForEach(boards.indices){
                    row in
                    VStack{
                        ForEach(boards[row].indices){
                            board in
                            ZStack{
                                Rectangle()
                                    .stroke(Color.black,lineWidth: 1)
                                    .frame(width: 30,height:30)
                                
                                switch boards[row][board]{
                                case .red:
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 30, height:30)
                                case .yellow:
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 30, height: 30)
                                case .green:
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 30, height: 30)
                                default:
                                    Text("")
                                }
                            }
                            
                        }
                        if game_state == .playing{
                            //if playing ,then you can put the chess down
                            Button(action: {
                                chess_pos = chessPosiotion(board_row:boards[row])
                                round_time=15
                                switch now_turn{
                                
                                case .red:
                                    
                                    if chess_pos >= 0{
                                        boards[row][chessPosiotion(board_row:boards[row])] = .red
                                        chessPlayer.playFromStart()
                                    }
                                    
                                case .yellow:
                                    if chess_pos >= 0{
                                        boards[row][chessPosiotion(board_row:boards[row])] = .yellow
                                        chessPlayer.playFromStart()
                                    }
                                    
                                }
                                win_pos=whoWin(boards: boards)
                                if win_pos.count > 1 {
                                    game_state = .win
                                    for chess in (1...(win_pos.endIndex-1)){
                                        boards[win_pos[chess][0]][win_pos[chess][1]] = .green
                                    }
                                }else if chess_pos>=0{
                                    if now_turn == .red{
                                        red_remain-=1
                                    }else{
                                        yellow_remain-=1
                                    }
                                    
                                    now_turn.change_turn()
                                }
                                if red_remain==0,yellow_remain==0{
                                    game_state = .draw
                                }
                                
                            }, label: {
                                Image(systemName: "chevron.up.circle")
                            })
                        }
                        
                        
                    }
                    
                }
            }
            //whose turn
            HStack{
                Text("Now turn is")
                if now_turn == .red{
                    Circle()
                        .fill(Color.red)
                        .frame(width: 20, height:20)
                }else{
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height:20)
                }
                
            }
            HStack{
                
                Text("Remain Time:")
                Text("\(round_time)").onReceive(timer){ _ in
                    if game_state == .playing{
                        if round_time > 0 {
                            round_time-=1
                        }else{
                            round_time=15
                            for row in boards.indices{
                                chess_pos = chessPosiotion(board_row:boards[row])
                                if chess_pos >= 0{
                                    switch now_turn{
                                    
                                    case .red:
                                        boards[row][chessPosiotion(board_row:boards[row])] = .red
                                        chessPlayer.playFromStart()
                                    
                                        
                                    case .yellow:
                                        boards[row][chessPosiotion(board_row:boards[row])] = .yellow
                                        chessPlayer.playFromStart()
                                    }
                                    win_pos=whoWin(boards: boards)
                                    if win_pos.count > 1 {
                                        game_state = .win
                                        for chess in (1...(win_pos.endIndex-1)){
                                            boards[win_pos[chess][0]][win_pos[chess][1]] = .green
                                        }
                                    }else if chess_pos>=0{
                                        if now_turn == .red{
                                            red_remain-=1
                                        }else{
                                            yellow_remain-=1
                                        }
                                        
                                        now_turn.change_turn()
                                    }
                                    if red_remain==0,yellow_remain==0{
                                        game_state = .draw
                                    }
                                    break
                                }
                            }
                    }
                    
                    }
                }
            }
            //gameover title
            if game_state == .win{
                HStack{
                    if now_turn == .red{
                        Text("Red")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.orange)
                    }else{
                        
                        Text("Yellow")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.orange)
                    }
                    Text(" Win")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.orange)
                }
                
            }else if game_state == .draw{
                Text("Draw").font(.title).foregroundColor(.gray)
            }
            
            //play again button
        
            Button(action: {
                BGMPlayer.playFromStart()
                
                if game_state == .win{
                    if now_turn == .red{
                        red_remain-=1
                        red_win+=1
                    }else{
                        yellow_remain-=1
                        yellow_win+=1
                    }
                }
                
                now_turn = Turn.yellow
                game_state = gameState.playing
                win_pos = [[0]]
                boards=Array(repeating: Array(repeating: board_state.blank, count: 6), count: 7 )
                red_remain=21
                yellow_remain=21
                round_time=15
            }, label: {
                Text("Play again?").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
        
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
