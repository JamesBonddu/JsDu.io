
# 自动补全

```ts
// 自动补全autocomplete解析结果
export interface AutocompleteParseResult {
  colRef?: {
    identifierChain: IdentifierChainEntry[];
  };
  commonTableExpressions?: {
    alias: string;
    columns: ColumnDetails[];
  }[];
  locations: IdentifierLocation[];
  lowerCase: boolean;
  subQueries: SubQuery[];
  suggestAggregateFunctions?: {
    tables: ParsedTable[];
  };
  suggestAnalyticFunctions?: boolean;
  suggestColRefKeywords?: {
    [type: string]: string[];
  };
  suggestColumnAliases?: ColumnAliasDetails[];
  suggestColumns?: {
    appendBacktick?: boolean;
    identifierChain?: IdentifierChainEntry[];
    source?: string;
    tables: ParsedTable[];
    types?: string[];
    udfRef?: string;
  };
  suggestCommonTableExpressions?: {
    appendBacktick?: boolean;
    name: string;
    prependFrom: boolean;
    prependQuestionMark: boolean;
  }[];
  suggestDatabases?: {
    appendBacktick?: boolean;
    appendDot?: boolean;
    prependFrom?: boolean;
    prependQuestionMark?: boolean;
  };
  suggestFilters?: {
    tables: ParsedTable[];
    prefix?: string;
  };
  suggestFunctions?: {
    types: string[];
    udfRef?: string;
  };
  suggestGroupBys?: CommonPopularSuggestion;
  suggestHdfs?: {
    path: string;
  };
  suggestJoins?: {
    prependJoin?: boolean;
    tables: ParsedTable[];
  };
  suggestJoinConditions?: {
    prependOn?: boolean;
    tables: ParsedTable[];
  };
  suggestIdentifiers?: {
    name: string;
    type: string;
  }[];
  suggestKeyValues?: unknown;
  suggestKeywords?: {
    value: string;
    weight: number;
  }[];
  suggestOrderBys?: CommonPopularSuggestion;
  suggestSetOptions?: boolean;
  suggestTables?: {
    appendBacktick?: boolean;
    identifierChain?: IdentifierChainEntry[];
    onlyTables?: boolean;
    onlyViews?: boolean;
    prependFrom?: boolean;
    prependQuestionMark?: boolean;
  };
  suggestValues?: {
    missingEndQuote?: boolean;
    partialQuote?: boolean;
  };
  udfArgument?: {
    name: string;
    position: number;
  };
  useDatabase?: string;
}

```