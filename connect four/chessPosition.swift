func chessPosiotion(board_row:[board_state]) -> Int{
    for board in (0...(board_row.count-1)).reversed() {
        if board_row[board] == .blank {
            return board
        }
    }
    return -2
}
