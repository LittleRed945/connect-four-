func whoWin(boards:[[board_state]])->Array<[Int]>{
    var win_pos=[[0]]
    var count=0
    for row in boards.indices{
        for column in boards[row].indices.reversed(){
            if boards[row][column] != .blank{
                count+=1
                if column>=3{
                    if row <= 3 {
                        if boards[row][column]==boards[row+1][column],boards[row][column]==boards[row+2][column],
                           boards[row][column]==boards[row+3][column]{
                            
                            win_pos.append([row,column])
                            win_pos.append([row+1,column])
                            win_pos.append([row+2,column])
                            win_pos.append([row+3,column])
                            return win_pos
                        }else if boards[row][column]==boards[row+1][column-1],boards[row][column]==boards[row+2][column-2],
                                 boards[row][column]==boards[row+3][column-3]{
                                  
                            win_pos.append([row,column])
                            win_pos.append([row+1,column-1])
                            win_pos.append([row+2,column-2])
                            win_pos.append([row+3,column-3])
                            return win_pos
                        }else if boards[row][column]==boards[row][column-1],boards[row][column]==boards[row][column-2],
                            boards[row][column]==boards[row][column-3]{
                             
                             win_pos.append([row,column])
                             win_pos.append([row,column-1])
                             win_pos.append([row,column-2])
                             win_pos.append([row,column-3])
                             return win_pos
                        }else if row==3,boards[row][column]==boards[row-1][column-1],boards[row][column]==boards[row-2][column-2],boards[row][column]==boards[row-3][column-3]{
                            win_pos.append([row,column])
                            win_pos.append([row-1,column-1])
                            win_pos.append([row-2,column-2])
                            win_pos.append([row-3,column-3])
                            return win_pos
                        }
                        
                    }else if row > 3{
                        if boards[row][column]==boards[row][column-1],boards[row][column]==boards[row][column-2],
                            boards[row][column]==boards[row][column-3]{
                             
                             win_pos.append([row,column])
                             win_pos.append([row,column-1])
                             win_pos.append([row,column-2])
                             win_pos.append([row,column-3])
                             return win_pos
                        }else if boards[row][column]==boards[row-1][column-1],boards[row][column]==boards[row-2][column-2],
                            boards[row][column]==boards[row-3][column-3]{
                            win_pos.append([row,column])
                            win_pos.append([row-1,column-1])
                            win_pos.append([row-2,column-2])
                            win_pos.append([row-3,column-3])
                            return win_pos
                        }
                    }
                }else if column>=0,column<=2{
                    if row <= 3 {
                        if boards[row][column]==boards[row+1][column],boards[row][column]==boards[row+2][column],
                           boards[row][column]==boards[row+3][column]{
                            
                            win_pos.append([row,column])
                            win_pos.append([row+1,column])
                            win_pos.append([row+2,column])
                            win_pos.append([row+3,column])
                            return win_pos
                        }
                        
                    }
                        
                    
                }
                
                    
                
            }
        }
    }
    if count == (boards.count * boards[0].count){
        win_pos=[[1]]
    }
    return win_pos
}
