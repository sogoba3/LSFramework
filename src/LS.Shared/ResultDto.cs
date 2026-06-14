using System;

namespace LS.Shared;

public class ResultDto
{
    public object? Result { get; set; }
    public bool HasError { get; set; } = false;
    public List<string> Errors { get; set; } = new List<string>();
    public string Message { get; set; } = string.Empty;
}

public interface IResultError {
    string UserMessage { get; set; }
}
