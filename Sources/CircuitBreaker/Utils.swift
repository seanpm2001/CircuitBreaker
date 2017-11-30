/**
* Copyright IBM Corporation 2017
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
**/

import Foundation

/// State
public enum State {
  
  /// The circuit is open i.e. broken
  case open

  /// The circuit is half-open i.e. experiencing errors
  case halfopen

  /// The circuit is closed i.e functioning normally
  case closed
}

/// Breaker Error
public enum BreakerError: CustomStringConvertible {

  /// The command timed out
  case timeout

  /// The command is failing fast
  case fastFail

  /// The command failed during context command invocation
  case invocationError(error: String)
  
  public var description: String {
    switch self {
    case .timeout: return "Breaker Timeout Error"
    case .fastFail: return "Breaker Fast Fail Error"
    case .invocationError(let error): return "Breaker Invocation Error: \(error)"
    }
  }
}

extension BreakerError: Equatable {

  public static func ==(lhs: BreakerError, rhs: BreakerError) -> Bool {
    switch (lhs, rhs) {
    case (.timeout, .timeout)                                 : return true
    case (.fastFail, .fastFail)                               : return true
    case (.invocationError(let e1), .invocationError(let e2)) : return e1 == e2
    default                                                   : return false
    }
  }
}

extension Date {
  public static func currentTimeMillis() -> UInt64 {
    let timeInMillis = UInt64(NSDate().timeIntervalSince1970 * 1000.0)
    return timeInMillis
  }
}

