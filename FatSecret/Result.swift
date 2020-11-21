enum Result<T> {
    case Success(data: T)
    case Failure(error: Error)
    case Loading
}
