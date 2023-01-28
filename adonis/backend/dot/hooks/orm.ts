import { string } from '@ioc:Adonis/Core/Helpers'
import { LucidModel, manyToMany } from '@ioc:Adonis/Lucid/Orm';
import User from 'App/Models/User';


/**
 * Define manyToMany relationship by `usedPivot` hook
 * @returns {ManyToManyDecorator}
 */
const usePivot = <RelatedModel extends LucidModel>(model: () => RelatedModel, tag: string | null = null) => {
<<<<<<< HEAD
  var table = global
  return manyToMany(model, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: string.singularize(model().table) + '_id',
    pivotTable: model().table + "_pivot",
=======
  var _model = model()
  var table = _model.table
  return manyToMany(model, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: string.singularize(table) + '_id',
    pivotTable: table + "_pivot",
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
const usedPivot = <RelatedModel extends LucidModel, RelatedToModel extends LucidModel>(model: () => RelatedModel, to: () => RelatedToModel, tag: string | null = null) => manyToMany(model, {
  pivotForeignKey: string.singularize(to().table) + '_id',
  pivotRelatedForeignKey: 'related_id',
  pivotTable: to().table + "_pivot",
  pivotColumns: ['tag'],
  onQuery: (builder) => {
    if (tag) {
      builder.wherePivot('tag', tag)
    }
  }
})
=======
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
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
export { usePivot, usedPivot };
