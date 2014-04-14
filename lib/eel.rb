require 'eel/active_record/query_extensions'
require 'eel/core_ext/symbol_extensions'

ActiveRecord::Relation.send :include, Eel::ActiveRecord::QueryExtensions
Symbol.send :include, Eel::CoreExt::SymbolExtensions


