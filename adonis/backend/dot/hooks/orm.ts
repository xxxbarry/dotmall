import { string } from '@ioc:Adonis/Core/Helpers'
import { LucidModel, manyToMany } from '@ioc:Adonis/Lucid/Orm';
import User from 'App/Models/User';


/**
 * Define manyToMany relationship by `usedPivot` hook
 * @returns {ManyToManyDecorator}
 */
const usePivot = <RelatedModel extends LucidModel>(model: () => RelatedModel, tag: string | null = null) => {
  var _model = model()
  var table = _model.table
  return manyToMany(model, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: string.singularize(table) + '_id',
    pivotTable: table + "_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      if (tag) {
        builder.wherePivot('tag', tag);
      }
    }
  });
}

/**
 * Define manyToMany relationship by `usedPivot` hook
 * @returns {ManyToManyDecorator}
 */
function usedPivot<RelatedModel extends LucidModel, RelatedToModel extends LucidModel>(model: () => RelatedModel, to: () => RelatedToModel, tag: string | null = null) {
  var _model = to()
  var table = _model.table
  return manyToMany(model, {
    pivotForeignKey: string.singularize(table) + '_id',
    pivotRelatedForeignKey: 'related_id',
    pivotTable: table + "_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      if (tag) {
        builder.wherePivot('tag', tag);
      }
    }
  });
}
export { usePivot, usedPivot };
